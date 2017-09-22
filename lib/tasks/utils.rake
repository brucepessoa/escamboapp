namespace :utils do
  desc "Cria Administradores Fake"
  task generate_admins: :environment do
	puts "Cadastrando o administradores..."
	10.times do
		Admin.create!(
			name: Faker::Name.name, 
			email: Faker::Internet.email, 
			password: "123456", 
			password_confirmation: "123456",
			role: [0,1,1,1].sample #sorteia o role entre os fakers. Mais role tipo 1 (restrito) do que 0 (fullaccess)
		)
	end
	puts "ADMINISTRADORES cadastrados com sucesso!"
  end

end


