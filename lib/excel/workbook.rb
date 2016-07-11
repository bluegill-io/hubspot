module Excel
  class Workbook
    def initialize
      @excel_book = RubyXL::Parser.parse './report.xlsx'
      DealsTable.new(@excel_book) 
      ContactsTable.new(@excel_book)

      write_to_file
    end

    def write_to_file
      @excel_book.write './report.xlsx'
    end
  end
end
