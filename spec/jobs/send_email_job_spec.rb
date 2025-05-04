require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SendEmailJob, type: :job do
  before do
    Sidekiq::Worker.clear_all
  end

  it "enqueues SendEmailJob" do
    expect {
      SendEmailJob.perform_async("What's up duuuude?", "user@example.com")
    }.to change(SendEmailJob.jobs, :size).by(1)
  end
end
