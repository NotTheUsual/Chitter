require_relative 'spec_helper'

describe Maker do
	let(:enrique) { Maker.new(name: "Enrique Comba Riepenhausen", username: "ecomba", email: "ecomba@makersacademy.com", password: "s3cr3t", password_confirmation: "s3cr3t") }
	
	context "(upon creation)" do
		it "should have an email address" do
			expect(enrique.email).to eq("ecomba@makersacademy.com")
		end
		it "should have a name" do
			expect(enrique.name).to eq("Enrique Comba Riepenhausen")
		end
		it "should have a username" do
			expect(enrique.username).to eq("ecomba")
		end
		it "should have a password digest" do
			expect(enrique.password_digest.length).to be > 10
		end
	end

	it "should be able to set the password disgest" do
		maker = Maker.new
		password = "s3cr3t"

		expect(BCrypt::Password).to receive(:create).and_return(password)

		maker.password = password
		expect(maker.password_digest).to eq(password)
	end

	context "(authentication)" do
		it "should return the user when authenticated" do
			expect(Maker).to receive(:first).with(username: "ecomba").and_return(enrique)
			expect(BCrypt::Password).to receive(:new).and_return("s3cr3t")
			expect(Maker.authenticate("ecomba", "s3cr3t")).to eq(enrique)
		end

		it "should return nil if there's no user" do
			expect(Maker).to receive(:first).with(username: "ecomba2").and_return(nil)
			expect(Maker.authenticate("ecomba2", "s3cr3t")).to eq(nil)
		end

		it "should return nil if the password is wrong" do
			expect(Maker).to receive(:first).with(username: "ecomba").and_return(enrique)
			expect(BCrypt::Password).to receive(:new).and_return("s3cr3t")
			expect(Maker.authenticate("ecomba", "secret")).to eq(nil)
		end
	end
end

# | name          | Enrique Comba Riepenhausen |
# | username      | ecomba                     |
# | email         | ecomba@makersacademy.com   |
# | password      | s3cr3t                     |
# | confirmation  | s3cr3t   