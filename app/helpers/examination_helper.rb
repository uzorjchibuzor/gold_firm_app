# frozen_string_literal: true

module ExaminationHelper
  def assign_letter_grade(score)
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

  def subject_percentage_score(examinations, subject, term)
    total_score = examinations.where(subject_id: subject.id, school_term: term.id).pluck(:score).sum || "Not Ready"
    letter_grade = assign_letter_grade(total_score)
    { total_score:, letter_grade: }
  end

  def find_score_by_type(examinations, type, subject, term)
    examinations.send(type).find_by(subject_id: subject.id, school_term_id: term.id)&.score || "AW"
  end
end
