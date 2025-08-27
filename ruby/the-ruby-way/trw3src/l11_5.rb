class Bank
  def open_safe
    # ... 
  end

  def close_safe
    # ...
  end

  private :open_safe, :close_safe

  def make_withdrawal(amount)
    if access_allowed
      open_safe
      get_cash(amount)
      close_safe
    end 
  end

  # make the rest private

private

  def get_cash
    # ...
  end

  def access_allowed
    # ...
  end 
end
