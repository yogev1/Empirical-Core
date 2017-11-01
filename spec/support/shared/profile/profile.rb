shared_context 'profile' do
  let(:teacher1) { FactoryBot.create(:user, role: 'teacher', name: 'Teacher 1') }
  let(:teacher2) { FactoryBot.create(:user, role: 'teacher', name: 'Teacher 2') }
  let!(:classroom1) { FactoryBot.create(:classroom, teacher: teacher1, name: 'class1') }
  let!(:classroom2) { FactoryBot.create(:classroom, teacher: teacher2, name: 'class2') }
  let!(:classroom3) { FactoryBot.create(:classroom, name: 'class3', code: 'coat-hanger') }
  let!(:student) { FactoryBot.create(:arnold_horshack, classrooms: [classroom1, classroom2]) }

  let(:game1) { FactoryBot.create(:activity_classification, id: 1) }
  let(:game2) { FactoryBot.create(:activity_classification, id: 2) }

  let(:activity) { FactoryBot.create(:activity, classification: game2) }
  let(:activity_1a) { FactoryBot.create(:activity, classification: game1) }
  let(:activity_1aa) { FactoryBot.create(:activity, classification: game2) }
  let!(:activity_1b) { FactoryBot.create(:activity, classification: game2) }
  let(:unit1) { FactoryBot.create(:unit) }
  let!(:classroom_activity) { FactoryBot.create(:classroom_activity,
                                                  classroom: classroom2,
                                                  activity: activity,
                                                  unit: unit1) }

  let!(:classroom_activity_1a) { FactoryBot.create(:classroom_activity,
                                                    classroom: classroom2,
                                                    activity: activity_1a,
                                                    unit: unit1)}


  let!(:classroom_activity_1aa) { FactoryBot.create(:classroom_activity,
                                                    classroom: classroom2,
                                                    activity: activity_1aa,
                                                    unit: unit1)}

  let!(:classroom_activity_1b) { FactoryBot.create(:classroom_activity,
                                                    classroom: classroom2,
                                                    activity: activity_1b,
                                                    unit: unit1)}

  let(:activity2) { FactoryBot.create(:activity, classification: game2) }
  let(:activity_2a) { FactoryBot.create(:activity, classification: game1) }
  let(:activity_2aa) { FactoryBot.create(:activity, classification: game2) }
  let(:activity_2b) { FactoryBot.create(:activity, classification: game2) }

  let!(:unit2) { FactoryBot.create(:unit) }
  let!(:classroom_activity2) { FactoryBot.create(:classroom_activity,
                                                  classroom: classroom2,
                                                  activity: activity2,
                                                  unit: unit2,
                                                  assigned_student_ids: [],
                                                  due_date: Date.today + 3) }

  let!(:classroom_activity_2a) { FactoryBot.create(:classroom_activity,
                                                    classroom: classroom2,
                                                    activity: activity_2a,
                                                    unit: unit2,
                                                    assigned_student_ids: [],
                                                    due_date: Date.today + 100)}

  let!(:classroom_activity_2aa) { FactoryBot.create(:classroom_activity,
                                                    classroom: classroom2,
                                                    activity: activity_2aa,
                                                    unit: unit2,
                                                    assigned_student_ids: [],
                                                    due_date: Date.today + 100)}


  let!(:classroom_activity_2b) { FactoryBot.create(:classroom_activity,
                                                    classroom: classroom2,
                                                    activity: activity_2b,
                                                    unit: unit2,
                                                    assigned_student_ids: [],
                                                    due_date: Date.today + 1)}




  let(:activity3) { FactoryBot.create(:activity, classification: game1) }

  let!(:unit3) { FactoryBot.create(:unit) }
  let!(:classroom_activity3) { FactoryBot.create(:classroom_activity,
                                                  classroom: classroom1,
                                                  activity: activity3,
                                                  unit: unit3,
                                                  due_date: Date.today + 3) }

  let!(:as1) { classroom_activity.session_for(student) }
  let!(:as_1a) { classroom_activity_1a.session_for(student) }
  let!(:as_1aa) { classroom_activity_1aa.session_for(student) }
  let!(:as_1b) { classroom_activity_1b.session_for(student) }

  let!(:as2) { classroom_activity2.session_for(student) }
  let!(:as_2a) { classroom_activity_2a.session_for(student) }
  let!(:as_2aa) { classroom_activity_2aa.session_for(student) }
  let!(:as_2b) { classroom_activity_2b.session_for(student) }

  let!(:as3_unstarted) { classroom_activity3.session_for(student) }
  let!(:as3_started) { classroom_activity3.session_for(student) }
  let!(:as3_finished) { classroom_activity3.session_for(student) }

  before do
    as1.update_attributes(percentage: 0.8, state: 'finished')
    as_1a.update_attributes(percentage: 0.5, state: 'finished')
    as_1aa.update_attributes(percentage: 0.5, state: 'finished')
    as_1b.update_attributes(percentage: 1, state: 'finished')
  end

  before do
    as3_unstarted.update_attributes(state: 'unstarted')
    as3_started.update_attributes(percentage: 0.5, state: 'started')
    as3_finished.update_attributes(percentage: 0.5, state: 'finished')
  end
end
