class JSONResult
  @success = true
  @data = nil
  def initialize(success, data)
    @success = success
    @data = data
  end
end