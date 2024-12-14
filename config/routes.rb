# frozen_string_literal: true

# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                                       Controller#Action
#                                     root GET    /                                                                                                 entries#index
#                            subscriptions GET    /subscriptions(.:format)                                                                          subscriptions#index
#                                          POST   /subscriptions(.:format)                                                                          subscriptions#create
#                         new_subscription GET    /subscriptions/new(.:format)                                                                      subscriptions#new
#                        edit_subscription GET    /subscriptions/:id/edit(.:format)                                                                 subscriptions#edit
#                             subscription GET    /subscriptions/:id(.:format)                                                                      subscriptions#show
#                                          PATCH  /subscriptions/:id(.:format)                                                                      subscriptions#update
#                                          PUT    /subscriptions/:id(.:format)                                                                      subscriptions#update
#                                          DELETE /subscriptions/:id(.:format)                                                                      subscriptions#destroy
#                                  entries GET    /entries(.:format)                                                                                entries#index
#                                    entry GET    /entries/:id(.:format)                                                                            entries#show
#                                          PATCH  /entries/:id(.:format)                                                                            entries#update
#                                          PUT    /entries/:id(.:format)                                                                            entries#update
#                                          DELETE /entries/:id(.:format)                                                                            entries#destroy
#                              new_session GET    /users/sign_in(.:format)                                                                          sessions#new
#                                  session POST   /users/sign_in(.:format)                                                                          sessions#create
#                          destroy_session DELETE /users/sign_out(.:format)                                                                         sessions#destroy
#                             new_password GET    /users/password/new(.:format)                                                                     passwords#new
#                            edit_password GET    /users/password/edit(.:format)                                                                    passwords#edit
#                                 password PATCH  /users/password(.:format)                                                                         passwords#update
#                                          PUT    /users/password(.:format)                                                                         passwords#update
#                                          POST   /users/password(.:format)                                                                         passwords#create
#                                edit_user GET    /users/profile(.:format)                                                                          users#edit
#                                     user PATCH  /users/profile(.:format)                                                                          users#update
#                                          PUT    /users/profile(.:format)                                                                          users#update
#                                 good_job        /good_job                                                                                         GoodJob::Engine
#         turbo_recede_historical_location GET    /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
#         turbo_resume_historical_location GET    /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
#        turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
#            rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#            rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
# new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create
#
# Routes for GoodJob::Engine:
#                root GET    /                                         good_job/jobs#redirect_to_index
#    mass_update_jobs GET    /jobs/mass_update(.:format)               redirect(301, path: jobs)
#                     PUT    /jobs/mass_update(.:format)               good_job/jobs#mass_update
#         discard_job PUT    /jobs/:id/discard(.:format)               good_job/jobs#discard
#   force_discard_job PUT    /jobs/:id/force_discard(.:format)         good_job/jobs#force_discard
#      reschedule_job PUT    /jobs/:id/reschedule(.:format)            good_job/jobs#reschedule
#           retry_job PUT    /jobs/:id/retry(.:format)                 good_job/jobs#retry
#                jobs GET    /jobs(.:format)                           good_job/jobs#index
#                 job GET    /jobs/:id(.:format)                       good_job/jobs#show
#                     DELETE /jobs/:id(.:format)                       good_job/jobs#destroy
# metrics_primary_nav GET    /jobs/metrics/primary_nav(.:format)       good_job/metrics#primary_nav
#  metrics_job_status GET    /jobs/metrics/job_status(.:format)        good_job/metrics#job_status
#         retry_batch PUT    /batches/:id/retry(.:format)              good_job/batches#retry
#             batches GET    /batches(.:format)                        good_job/batches#index
#               batch GET    /batches/:id(.:format)                    good_job/batches#show
#  enqueue_cron_entry POST   /cron_entries/:cron_key/enqueue(.:format) good_job/cron_entries#enqueue
#   enable_cron_entry PUT    /cron_entries/:cron_key/enable(.:format)  good_job/cron_entries#enable
#  disable_cron_entry PUT    /cron_entries/:cron_key/disable(.:format) good_job/cron_entries#disable
#        cron_entries GET    /cron_entries(.:format)                   good_job/cron_entries#index
#          cron_entry GET    /cron_entries/:cron_key(.:format)         good_job/cron_entries#show
#           processes GET    /processes(.:format)                      good_job/processes#index
#   performance_index GET    /performance(.:format)                    good_job/performance#index
#         performance GET    /performance/:id(.:format)                good_job/performance#show
#       cleaner_index GET    /cleaner(.:format)                        good_job/cleaner#index
#     frontend_module GET    /frontend/modules/:version/:id(.:format)  good_job/frontends#module {:version=>"4-6-0", :format=>"js"}
#     frontend_static GET    /frontend/static/:version/:id(.:format)   good_job/frontends#static {:version=>"4-6-0"}

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'entries#index'

  # Resource based routes
  resources :subscriptions
  resources :entries, only: %i[index show update destroy]

  # Special routes for sign in/out and profile
  scope :users do
    resource :session, only: [], path: '' do
      get :new, path: '/sign_in', as: :new
      post :create, path: '/sign_in'
      delete :destroy, path: '/sign_out', as: :destroy
    end

    resource :password, only: %i[new create edit update]

    resource :user, path: 'profile', only: %i[update] do
      get :edit, path: ''
    end
  end

  # Only allow access to GoodJob dashboard if user is an admin
  constraints(->(request) { User.find_by(id: request.session[:user_id])&.admin? }) do
    mount GoodJob::Engine => 'good_job'
  end
end
