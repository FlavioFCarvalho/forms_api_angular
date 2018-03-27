describe "GET /forms" do
    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :get, "/api/v1/forms"
    end

    context "With Valid authentication headers" do
      before do
        @user = create(:user)
        @form1 = create(:form, user: @user)
        @form2 = create(:form, user: @user)

        get "/api/v1/forms", params: {}, headers: header_with_authentication(@user)
      end

      it "returns 200" do
        expect_status(200)
      end

      it "returns Form list with 2 forms" do
        expect(json.count).to eql(2)
      end

      it "returned Forms have right datas" do
        expect(json[0]).to eql(JSON.parse(@form1.to_json))
        expect(json[1]).to eql(JSON.parse(@form2.to_json))
      end
    end
  end