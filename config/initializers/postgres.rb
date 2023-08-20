# frozen_string_literal: true

require 'active_record/connection_adapters/postgresql_adapter'

# Make sure all datetime columns use a ttimestamp with time zone
ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.datetime_type = :timestamptz
