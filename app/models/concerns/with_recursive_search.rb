# frozen_string_literal: true

module WithRecursiveSearch
  extend ActiveSupport::Concern

  module ClassMethods
    def descendants_by_id(*ids, include_self: false)
      with_recursive_query(ids, recursive_alias[:id].eq(arel_table[:parent_id]), include_self:)
    end

    def ancestors_by_id(*ids, include_self: false)
      with_recursive_query(ids, recursive_alias[:parent_id].eq(arel_table[:id]), include_self:)
    end

    private

    def recursive_alias
      Arel::Table.new('categories_tree')
    end

    def with_recursive_query(ids, on_clause, include_self:)
      alias_definition = Arel::Nodes::SqlLiteral.new("#{recursive_alias.name}(#{column_names.join(',')})")
      cte = Arel::Nodes::TableAlias.new(send(:sub_query_for_recursive, ids, on_clause), alias_definition)
      query = recursive_alias.project('*')
      query.where(recursive_alias[:id].not_in(ids)) unless include_self
      find_by_sql(query.with(:recursive, cte))
    end

    def sub_query_for_recursive(ids, on_clause)
      union_query = select(column_names.map { |c| arel_table[c] }).arel.join(recursive_alias).on(on_clause)
      select(column_names).where(id: ids).arel.union(:all, union_query)
    end
  end
end
