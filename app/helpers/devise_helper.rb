module DeviseHelper
  def bootstrap_alert(key)
    lists = {
      'alert' => 'warning',
      'notice' => 'success',
      'error' => 'danger'
    }
    lists[key]
  end
end
