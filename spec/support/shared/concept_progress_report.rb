shared_context 'Concept Progress Report' do
  # Stats should come out like this:
  # name,         result_count,     correct_count,      incorrect_count,
  # Writing,      3,                2,                  1
  # Grammar,      2,                1,                  1

  # When filtered by empty_classroom, nothing displays
  # when filtered by empty_unit, nothing displays
  # When filtered by unassigned student, nothing displays

  let!(:activity) { create(:activity) }
  let!(:student) { create(:student) }
  let!(:classroom) { create(:classroom, teacher: teacher, students: [student]) }
  let!(:unit) { create(:unit) }
  let!(:classroom_activity) { create(:classroom_activity,
                                          classroom: classroom,
                                          activity: activity,
                                          unit: unit) }

  let!(:writing_grandparent_concept) { create(:concept, name: 'Writing Grandparent') }
  let!(:writing_parent_concept) { create(:concept, name: 'Writing Parent', parent: writing_grandparent_concept)}
  let!(:writing_concept) { create(:concept, name: "Writing Tag", parent: writing_parent_concept) }
  let!(:grammar_tag) { create(:concept, name: "Grammar Tag") }

  let!(:activity_session) { create(:activity_session,
                                        classroom_activity: classroom_activity,
                                        user: student,
                                        activity: activity,
                                        state: 'finished',
                                        percentage: 0.75
                                        ) }

  let!(:correct_writing_result1) { create(:concept_result,
    activity_session: activity_session,
    concept: writing_concept,
    metadata: {
      "correct" => 1
    }) }

  let!(:correct_writing_result2) { create(:concept_result,
    activity_session: activity_session,
    concept: writing_concept,
    metadata: {
      "correct" => 1
    }) }

  let!(:incorrect_writing_result) { create(:concept_result,
    activity_session: activity_session,
    concept: writing_concept,
    metadata: {
      "correct" => 0
    }) }

  let!(:correct_grammar_result) { create(:concept_result,
    activity_session: activity_session,
    concept: grammar_tag,
    metadata: {
      "correct" => 1
    }) }

  let!(:incorrect_grammar_result) { create(:concept_result,
    activity_session: activity_session,
    concept: grammar_tag,
    metadata: {
      "correct" => 0
    }) }

  # Should not be visible on the report
  let!(:other_teacher) { create(:teacher) }
  let!(:other_student) { create(:student) }
  let!(:other_classroom) { create(:classroom, teacher: other_teacher) }
  let!(:other_unit) { create(:unit) }
  let!(:other_classroom_activity) { create(:classroom_activity,
    classroom: other_classroom,
    unit: other_unit,
    activity: activity) }
  let!(:other_activity_session) { create(:activity_session,
    classroom_activity: other_classroom_activity,
    user: other_student,
    state: 'finished',
    percentage: 0.75) }
  let!(:other_grammar_result) { create(:concept_result,
    activity_session: other_activity_session,
    concept: writing_concept,
    metadata: {
      "correct" => 1
    }) }

  let!(:writing_results) { [correct_writing_result1, correct_writing_result2, incorrect_writing_result] }
  let!(:grammar_results) { [correct_grammar_result, incorrect_grammar_result] }
end