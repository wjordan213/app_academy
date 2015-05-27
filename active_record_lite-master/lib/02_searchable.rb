require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # here self is a Class object
    qualities = params.keys.map { |attrib| attrib.to_s + ' = ?'}.join(' AND ')
    conditional_vals = params.values

    data = DBConnection.execute(<<-SQL, *conditional_vals)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{qualities}
    SQL
    self.parse_all(data)
  end
end

class SQLObject
  extend Searchable
end
