require_relative "bulk_merger"

abort('abort: GITHUB_TOKEN not set in environment.') unless ENV['GITHUB_TOKEN']

BulkMerger.merge_approved_pull_requests!
