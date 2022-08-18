class CreateCompletionJob < ApplicationJob
  queue_as :default

  def perform(suggestion)
    response = openai_client.completions(
      engine: "text-davinci-002",
      parameters: {
        prompt: suggestion.prompt.to_s,
        temperature: 0.7,
        max_tokens: suggestion.destination.max_length,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0
      }
    )
    content = response.parsed_response['choices'].map{ |c| c["text"] }.join(" ")
    suggestion.update!(
      content: content,
      data: response.parsed_response,
      completion_tokens: response.parsed_response["usage"]["completion_tokens"],
      prompt_tokens: response.parsed_response["usage"]["prompt_tokens"],
      total_tokens: response.parsed_response["usage"]["total_tokens"],
    )
    ReportUsageJob.perform_later(suggestion)
  end

  def openai_client
    @client ||= OpenAI::Client.new(
      access_token: Rails.application.credentials.openai[:secret],
    )
  end
end
