# Sidekiq Middleware to report all errors to sentry
# This is a server-side middleware that reports any exception from any job
# See more: https://github.com/mperham/sidekiq/wiki/Middleware
module Sidekiq::Middleware::Server
  class SentryErrorLogger
    def call(worker, job, queue)
      begin
        yield
      rescue => error
        Raven.capture_exception(error,
                                extra: {
                                  worker: worker,
                                  job: job,
                                  queue: queue
                                })
        # we raise it after reporting it to sentry.
        # Raise is important here because this raise will tell
        # sidekiq to mark this job as failed and move that job in retry queue
        raise
      end
    end
  end
end
