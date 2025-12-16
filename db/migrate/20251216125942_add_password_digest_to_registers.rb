class AddPasswordDigestToRegisters < ActiveRecord::Migration[8.0]
  def change
    add_column :registers, :password_digest, :string
  end
end
