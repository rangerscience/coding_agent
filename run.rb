#!/usr/bin/env ruby
# frozen_string_literal: true

# Load the gems and environment variables from .env file.
Dir.chdir(__dir__) do
  require 'bundler/setup'
  require 'dotenv/load'
end

require 'ruby_llm'
require_relative 'src/agent'

RubyLLM.configure do |config|
  config.anthropic_api_key = ENV.fetch('ANTHROPIC_API_KEY', nil)
  config.default_model = 'claude-3-7-sonnet'

  config.retry_interval = 60 # seconds
  config.retry_backoff_factor = 2
end

# Allow specifying a working directory as a command-line argument
working_dir = ARGV[0] || './'
Agent.new(working_dir: working_dir).run
