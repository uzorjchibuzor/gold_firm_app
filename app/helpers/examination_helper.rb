# frozen_string_literal: true

module ExaminationHelper
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

  def subject_percentage_score(exam_term_subject_params)
    total_score = exam_term_subject_params[:examinations].filter { |examination| examination.school_term_id == exam_term_subject_params[:term_id] }.map(&:score).sum || "Not Ready"
    letter_grade = assign_letter_grade(total_score)
    { total_score:, letter_grade: }
  end


  def find_score_by_type(exam_term_subject_params, type)
    exam_term_subject_params[:examinations].send(type).find { |examination| examination.school_term_id == exam_term_subject_params[:term_id] && examination.subject_id == exam_term_subject_params[:subject_id] }&.score || "Not Found"
  end
end
