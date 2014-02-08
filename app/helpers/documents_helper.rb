module DocumentsHelper
  
  def document_type(role,cs,doc)
    "/"+role+"/"+doc+"/"+cs+"/new"
  end
end
