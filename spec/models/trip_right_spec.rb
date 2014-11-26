describe TripRight do
  let(:trip_id) { 1 }
  let(:user_id) { 2 }
  let(:trip_right) do
    TripRight.new(
      user_id: user_id,
      trip_id: trip_id,
      permission: permission
    )
  end

  describe '#can_edit?' do
    subject(:can_edit?) { trip_right.can_edit? }
    [
      { permission: :owner, result: true },
      { permission: :collaborator, result: true },
      { permission: :viewer, result: false },
    ].each do |testcase|
      context "given the user has #{testcase[:permission]} rights" do
        let(:permission) { testcase[:permission] }
        it { is_expected.to eq(testcase[:result]) }
      end
    end
  end

  describe '#can_view?' do
    subject(:can_view?) { trip_right.can_view? }
    [
      { permission: :owner, result: true },
      { permission: :collaborator, result: true },
      { permission: :viewer, result: true },
    ].each do |testcase|
      context "given the user has #{testcase[:permission]} rights" do
        let(:permission) { testcase[:permission] }
        it { is_expected.to eq(testcase[:result]) }
      end
    end
  end
end
