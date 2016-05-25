module Excel
  class Workbook
  
    def initialize
      @excel_document = Spreadsheet::Workbook.new
      DealsTable.new(@excel_document)
      # add more writes here for our other records/ 
      # ContactsTable.new

      # last step after we've created all our sheets
      write_to_file
    end

    def write_to_file
      @excel_document.write './boom.xls'
    end
  end
end
