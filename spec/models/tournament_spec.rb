require 'rails_helper'

RSpec.describe Tournament, :type => :model do
  let(:name) { 'Some Name' }
  let(:end_date) { 1.week.from_now.to_s }
  let(:players) { Array.new(5) { Player.create(name: Faker::Name.first_name) } }
  let(:params) { { name: name, players: players.map(&:id), end_date: end_date } }

  before do
    creator = TournamentCreator.new(params)
    creator.save
    @tournament = creator.tournament
  end

  describe '#players_by_points' do
    let(:player1) { players.first }
    let(:player2) { players.second }
    let(:player2_matchups) { @tournament.matchups_for player2 }

    before do
      player2_matchups.each { |match| match.update_column('winner_id', player2.id) }
    end

    it 'returns a list of players ranked by how many points they won' do
      expect(@tournament.players_by_points.first).to eq player2
    end
  end

  describe '#rank_for player' do
    let(:player1) { players.first }
    let(:player2) { players.second }
    let(:player1_matchups) { @tournament.matchups_for player1 }
    subject { @tournament.rank_for(player1) }

    before do
      player1_matchups.each { |match| match.winner_id = player1.id }
    end

    it 'returns a list of players ranked by how many points they won' do
      expect( @tournament.rank_for(player1) ).to eq '1st'
    end
  end

  describe '#add_player' do
    let(:new_player) { Player.create name: 'Player 1' }
    context 'successfully adds player' do
      it 'builds the matches for the player' do
        expect(@tournament.matchups.count).to be 10
        expect(@tournament.players.count).to be 5
        @tournament.add_player new_player
        expect(@tournament.matchups.count).to be 15
        expect(@tournament.players.count).to be 6
      end
    end
  end
end
