require 'rails_helper'

describe ProgressReports::Concepts::User do
  include_context 'Concept Progress Report'

  let!(:teacher) { create(:teacher) }
  let(:section_ids) { [sections[0].id, sections[1].id] }

  subject { described_class.results(teacher, filters).to_a }

  context 'no filters' do
    let(:filters) { {} }

    it 'can retrieve users based on no filters' do
      expect(subject.size).to eq(1)
    end
  end

  context 'classrooms' do
    let(:filters) { {classroom_id: classroom.id} }

    it 'can retrieve users based on classroom_id' do
      expect(subject.size).to eq(1)
    end
  end

  context 'units' do
    let(:filters) { {unit_id: unit.id} }

    it 'can retrieve users based on unit_id' do
      expect(subject.size).to eq(1)
    end
  end
end