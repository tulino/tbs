class UsersDatatable < AjaxDatatablesRails::Base

  def_delegator :@view, :link_to

  def view_columns
    @view_columns ||= {
      first_name: { source: "User.first_name" },
      last_name: { source: "User.last_name" },
      ubs_no: { source: "User.ubs_no", orderable: false },
      tc_no: { source: "User.idnumber", orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        first_name: link_to(record.first_name, record.profile),
        last_name: record.last_name,
        ubs_no: record.try(:ubs_no),
        tc_no: record.try(:idnumber)
      }
    end
  end

  private

  def get_raw_records
    User.all
  end
end
