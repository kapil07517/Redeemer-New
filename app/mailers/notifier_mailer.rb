class NotifierMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def email_invoice_details(invoice,client)
    @invoice = invoice
    @client = client
    attachments['invoice.pdf'] = WickedPdf.new.pdf_from_string(
      render_to_string(:pdf => 'InvoicePDF',:encoding=>"UTF-8",:template => 'counselor/invoices/show.html.erb')
    )
    mail(:to => @client.email, :subject => "Invoice Details")
  end
end
