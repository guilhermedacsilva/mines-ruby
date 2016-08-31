GameMines.load('lib/util/forwardable_with_params')

module GameMines
  # Used for tests
  class PersonWithDelegator
    extend ForwardableWithParams

    def_delegator_with_params :self, :ret_val, :ret_val_int_20, 20
    def_delegator_with_params :self, :ret_val, :ret_val_array_20, [20]

    def ret_val(val)
      val
    end
  end
end
