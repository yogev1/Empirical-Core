require 'rails_helper'

describe FinishActivityWorker, type: :worker do
  let(:worker) { FinishActivityWorker.new }
  let(:analytics) { SegmentAnalytics.new }
  let(:classroom) { FactoryBot.create(:classroom) }
  let!(:unit) {FactoryBot.create(:unit)}
  let(:classroom_activity) { FactoryBot.create(:classroom_activity, classroom: classroom, unit: unit) }
  let(:activity_session) { FactoryBot.create(:activity_session, state: 'finished', classroom_activity: classroom_activity) }

  it 'sends a segment.io event' do
    worker.perform(activity_session.uid)

    expect(analytics.backend.track_calls.size).to eq(1)
    expect(analytics.backend.track_calls[0][:event]).to eq(SegmentIo::Events::ACTIVITY_COMPLETION)
  end
end
