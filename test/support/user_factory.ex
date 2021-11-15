defmodule MyApi.UserFactory do

  use ExMachina.Ecto, repo: MyApi.Repo

  @spec __using__(any) ::
          {:def, [{:context, MyApi.UserFactory} | {:import, Kernel}, ...],
           [[{any, any}, ...] | {:users_factory, [...], MyApi.UserFactory}, ...]}
  defmacro __using__(_opts) do
    quote do
      def users_factory do
        %MyApi.Accounts.User{
          username: "useruser",
          password: "pwdpwdpwd",
          password_confirmation: "pwdpwdpwd"
        }
      end
    end
  end


end
