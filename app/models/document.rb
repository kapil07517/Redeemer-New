class Document < ActiveRecord::Base
  attr_accessible :document,:case_id,:intake_form_id,:client_id,:case_num,:progress_note_id,:adolesment_intake_id,:discharge_summary_id,:intake_evalution_id,:doc_type,:appointment_id
  attr_accessor :case_num,:appointment_id
  belongs_to :case
  belongs_to :client
  belongs_to :progress_note
  belongs_to :adolesment_intake
  belongs_to :discharge_summary
  belongs_to :intake_evalution
  belongs_to :intake_form
  has_attached_file :document
  validates_attachment :document, :presence => true,
    :content_type => { :content_type => ["image/jpg","image/jpeg","application/pdf", "application/x-pdf"],:message => 'only jpg or pdf files' }
  validate :case_num_val
  
  def case_num_val
    cs = Case.find_by_number(self.case_num)
    if self.case_num and cs == nil
      self.errors.add(:case_num,"number not exists!")
    end
  end
end
