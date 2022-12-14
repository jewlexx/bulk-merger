require "octokit"

class BulkMerger
  def self.merge_approved_pull_requests(regexp: Regexp)
    unmerged_pull_requests = find_pull_requests(regexp)

    if unmerged_pull_requests.size == 0
      puts "No unmerged PRs found!"
      return
    end

    puts "Found #{unmerged_pull_requests.size} reviewed but unmerged PRs:\n\n"

    unmerged_pull_requests.each do |pr|
      puts "- '#{pr.title}' (#{pr.html_url}) "
    end

    puts "\nHave you reviewed the changes, and you want to MERGE all these PRs? [y/N]\n"
    if STDIN.gets.chomp == "y"
      puts "OK! 👍 Merging away..."
    else
      puts "👋"
      exit 1
    end

    unmerged_pull_requests.each do |pr|
      print "Merging PR '#{pr.title}' (#{pr.html_url}) "

      repo = pr.repository_url.gsub("https://api.github.com/repos/", "")

      begin
        client.merge_pull_request(repo, pr.number)
        puts "✅"
      rescue Octokit::MethodNotAllowed => e
        puts "❌ Failed to merge: #{e.message.inspect}"
      end
    end
  end

  def self.search_pull_requests(query: Regexp)
    client.search_issues("archived:false is:pr state:open").items
  end

  def self.repos
    @repos ||= client.search_repos()
      .items
      .reject!(&:archived)
      .map { |repo| repo.full_name }
  end

  def self.find_pull_requests(query: Regexp)
    search_pull_requests(query).select do |pr|
      repos.any? { |repo| pr.repository_url.include?(repo) }
    end
  end

  def self.client
    @client ||= Octokit::Client.new(access_token: ENV.fetch("GITHUB_TOKEN"), auto_paginate: true)
  end

  def self.query_string
    ENV.fetch("QUERY_STRING")
  end
end
