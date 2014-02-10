module DocumentsHelper
  
  def document_type(role,cs,doc)
    "/"+role+"/"+doc+"/"+cs+"/new"
  end
  
  def document_redirect(role,cs,doc)
    if doc == "intake_evalution"
      "/"+role+"/initial_evalutions/"+cs+"/client_intake_evalution"
    elsif doc == "discharge_summary"
      "/"+role+"/discharge_summary/"+cs+"/client_discharge_summary"
    else doc == "adolesment_intake"
      "/"+role+"/adolesment_intakes/"+cs+"/client_adolesment_intake"
    end
  end
end
