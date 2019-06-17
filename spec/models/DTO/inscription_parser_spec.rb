require 'rspec'
require_relative '../../../app/helpers/inscription_parser'
describe 'inscription parser' do
  let(:parser) do
    InscriptionParser.new
  end

  let(:codes) do
    [7524, 7311]
  end

  it 'should return an array with field cupos and the code' do
    expect(parser.parse_codes(codes)).to eq [{ 'cupo': 7524 }, { 'cupo': 7311 }]
  end
end
