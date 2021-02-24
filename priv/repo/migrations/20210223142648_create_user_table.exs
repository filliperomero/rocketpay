defmodule Rocketpay.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  # 'change' will create or do a rollback
  # if you want to separe that, just use 'def up' and 'def down'
  def change do
    create table :users do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password_hash, :string
      add :nickname, :string

      # Add inserted_At and updated_At
      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end
end
