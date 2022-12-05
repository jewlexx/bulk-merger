require_relative "bulk_merger"

abort('abort: GITHUB_TOKEN not set in environment.') unless ENV['GITHUB_TOKEN']

title = ENV['TITLE']

title_regexp = Regexp.new title

BulkMerger.merge_approved_pull_requests(title_regexp)
