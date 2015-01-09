require 'spec_helper'

describe AreasController, type: :controller do
  let(:current_user) { User.create!(email: 'e@ma.il', password: 'double') }
  let(:trip) { Trip.create! }
  let(:area) { Area.create!(:trip_id => trip.id) }
  let(:area_presenter) { AreaPresenter.new(area) }

  before do
    allow(AreaPresenter).to receive(:new).
      with(area).
      and_return(area_presenter)
    allow(Area).to receive(:new).
      and_return(area)

    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in current_user
  end

  describe '#index' do
    context 'user does not have permission to view the areas' do
      before do
        allow(TripRight).to receive(:user_can_view?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(false)
      end

      it 'does not allow the user to view the areas' do
        expect(get :index, trip_id: trip.id).to redirect_to(trips_path)
      end
    end

    context 'user has permission to view the areas' do
      before do
        allow(TripRight).to receive(:user_can_view?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(true)
      end

      it 'allows the user to view the areas' do
        expect(get :index, trip_id: trip.id).to render_template(:index)
      end
    end
  end

  describe '#show' do
    context 'user does not have permission to view the area' do
      before do
        allow(TripRight).to receive(:user_can_view?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(false)
      end

      it 'does not allow the user to view the area' do
        expect(get :show, id: area.id, trip_id: trip.id).to redirect_to(trips_path)
      end
    end

    context 'user has permission to view the areas' do
      before do
        allow(TripRight).to receive(:user_can_view?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(true)
      end

      it 'allows the user to view the area' do
        expect(get :show, id: area.id, trip_id: trip.id).to render_template(:show)
      end

      it 'assigns the correct presenter' do
        get :show, id: area.id, trip_id: trip.id
        expect(assigns(:presenter)).to eq(area_presenter)
      end
    end
  end

  describe '#new' do
    context 'user does not have permission to append areas' do
      before do
        allow(TripRight).to receive(:user_can_edit?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(false)
      end

      it 'does not allow the user to append areas' do
        expect(get :new, trip_id: trip.id).to redirect_to(trips_path)
      end
    end

    context 'user has permission to append areas' do
      before do
        allow(TripRight).to receive(:user_can_edit?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(true)
      end

      it 'allows the user to append areas' do
        expect(get :new, trip_id: trip.id).to render_template(:new)
      end

      it 'assigns a new blank area' do
        get :new, trip_id: trip.id
        expect(assigns(:area)).to eq(area)
      end
    end
  end

  describe '#edit' do
    context 'user does not have permission to edit the area' do
      before do
        allow(TripRight).to receive(:user_can_edit?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(false)
      end

      it 'does not allow the user to edit the area' do
        expect(get :edit, id: area.id, trip_id: trip.id).to redirect_to(trips_path)
      end
    end

    context 'user has permission to edit the area' do
      before do
        allow(TripRight).to receive(:user_can_edit?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(true)
      end

      it 'allows the user to edit the area' do
        expect(get :edit, id: area.id, trip_id: trip.id).to render_template(:edit)
      end
    end
  end

  describe '#create' do
    context 'user does not have permission to create new areas' do
      before do
        allow(TripRight).to receive(:user_can_edit?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(false)
      end

      it 'does not allow the user to create new areas' do
        expect(post :create, id: area.id, trip_id: trip.id).to redirect_to(trips_path)
      end
    end

    context 'user has permission to create new areas' do
      before do
        allow(TripRight).to receive(:user_can_edit?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(true)
      end

      context 'area params are not provided' do
        let(:area_parameters) { nil }

        it 'explodes' do
          expect{ post :create, trip_id: trip.id, area: area_parameters }.to raise_error
        end
      end

      context 'saving a new area succeeds' do
        let(:area_parameters) do
          {
            trip_id: trip.id,
            name: "area name",
            description: "area description",
            cost: Money.new(1_00),
            image: "http://area.image",
            proposed_date: Time.now,
          }
        end

        before do
          allow(Area).to receive(:new).
            and_call_original
        end

        it 'does create the new area' do
          expect{ post :create, trip_id: trip.id, area: area_parameters }.to change{ Area.count }.by(1)
        end
      end
    end
  end

  describe '#update' do
    context 'user does not have permission to edit the areas' do
      before do
        allow(TripRight).to receive(:user_can_edit?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(false)
      end

      it 'does not allow the user to edit the areas' do
        expect(put :update, id: area.id, trip_id: trip.id).to redirect_to(trips_path)
      end
    end


    context 'user has permission to edit the areas' do
      before do
        allow(TripRight).to receive(:user_can_edit?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(true)
      end

      context 'area params are not provided' do
        let(:area_parameters) { nil }

        it 'explodes' do
          expect{ put :update, id: area.id, trip_id: trip.id, area: area_parameters }.to raise_error
        end
      end

      context 'updating an area succeeds' do
        let(:area_parameters) do
          {
            trip_id: trip.id,
            name: "area name",
            description: "area description",
            cost: Money.new(1_00),
            image: "http://area.image",
            proposed_date: Time.now,
          }
        end

        before do
          allow(Area).to receive(:find).
            and_return(area)
        end

        it 'updates the area' do
          put :update, id: area.id, trip_id: trip.id, area: area_parameters
          expect(area.name).to eq("area name")
        end
      end
    end
  end

  describe '#destroy' do
    context 'user does not have permission to edit the areas' do
      before do
        allow(TripRight).to receive(:user_can_edit?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(false)
      end

      it 'does not allow the user to delete the areas' do
        expect(delete :destroy, id: area.id, trip_id: trip.id).to redirect_to(trips_path)
      end
    end

    context 'user has permission to edit the areas' do
      before do
        allow(TripRight).to receive(:user_can_edit?).
          with(
            user_id: current_user.id,
            trip_id: trip.id
          ).
          and_return(true)
      end

      it 'allows the user to delete the area' do
        expect{ delete :destroy, id: area.id, trip_id: trip.id }.to change{ Area.count }.by(-1)
      end
    end
  end

end
