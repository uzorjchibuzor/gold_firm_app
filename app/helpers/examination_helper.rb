# frozen_string_literal: true

module ExaminationHelper
  def action_button_for_examination(type, options)
    current_exam = options[:examinations].send(type).find { |examination| examination.school_term_id == options[:school_term_id] && examination.subject_id == options[:subject_id] }
    if current_exam.present?
      link_to "Change", edit_examination_path(id: current_exam.id), id: "examination_id_#{current_exam.id}_subject_id_#{options[:subject_id]}", class: "px-3 py-2 bg-yellow-600 text-white font-medium text-xs leading-tight rounded shadow-md hover:bg-yellow-700 hover:shadow-lg focus:bg-green-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-green-800 active:shadow-lg transition duration-150 ease-in-out"
    else
      link_to "Create", new_examination_path(examination: { school_term_id: options[:school_term_id], subject_id: options[:subject_id], grade_level_id: options[:grade_level_id], user_id: options[:user_id], exam_type: type }), id: "examination_for_subject_id_#{options[:subject_id]}", class: "px-3 py-2 bg-green-600 text-white font-medium text-xs leading-tight rounded shadow-md hover:bg-green-700 hover:shadow-lg focus:bg-green-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-green-800 active:shadow-lg transition duration-150 ease-in-out"
    end
  end

  def assign_letter_grade(score)
    return "No Score" if score.nil?
    return "F9" if (00..39).include? score
    return "E8" if (40..44).include? score
    return "D7" if (45..49).include? score
    return "C6" if (50..54).include? score
    return "C5" if (55..59).include? score
    return "C4" if (60..64).include? score
    return "B3" if (65..69).include? score
    return "B2" if (70..74).include? score
    "A1"
  end

  def subject_percentage_score(options)
    total_score = options[:examinations].filter { |examination| examination.school_term_id == options[:school_term_id] && examination.subject_id == options[:subject_id] }.map(&:score).sum || "Not Ready"
    letter_grade = assign_letter_grade(total_score)
    { total_score:, letter_grade: }
  end


  def find_score_by_type(type, options)
    options[:examinations].send(type).find { |examination| examination.school_term_id == options[:school_term_id] && examination.subject_id == options[:subject_id] }&.score || "Not Found"
  end
end
