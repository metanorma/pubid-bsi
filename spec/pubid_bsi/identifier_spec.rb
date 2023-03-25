module Pubid::Bsi
  RSpec.describe Identifier do
    subject { described_class.parse(original || pubid) }
    let(:original) { nil }

    context "BS 0" do
      let(:pubid) { "BS 0" }

      it_behaves_like "converts pubid to pubid"
    end

    context "BS 7121-3:2017" do
      let(:pubid) { "BS 7121-3:2017" }

      it_behaves_like "converts pubid to pubid"
    end

    context "PAS 1192-2:2014" do
      let(:pubid) { "PAS 1192-2:2014" }

      it_behaves_like "converts pubid to pubid"
    end

    context "PD 19650-0:2019" do
      let(:pubid) { "PD 19650-0:2019" }

      it_behaves_like "converts pubid to pubid"
    end

    context "Flex 8670:2021-04" do
      let(:original) { "Flex 8670:2021-04" }
      let(:pubid) { "BSI Flex 8670:2021-04" }

      it_behaves_like "converts pubid to pubid"
    end

    context "Flex 8670 v3.0:2021-04" do
      let(:original) { "Flex 8670 v3.0:2021-04" }
      let(:pubid) { "BSI Flex 8670 v3.0:2021-04" }

      it_behaves_like "converts pubid to pubid"
    end

    context "BSI Flex 1889 v1.0:2022-07" do
      let(:pubid) { "BSI Flex 1889 v1.0:2022-07" }

      it_behaves_like "converts pubid to pubid"
    end

    context "ISO 37101:2016" do
      let(:pubid) { "ISO 37101:2016" }

      it_behaves_like "converts pubid to pubid"
    end

    context "ISO/IEC 29151" do
      let(:pubid) { "ISO/IEC 29151" }

      it_behaves_like "converts pubid to pubid"
    end

    context "IEC 62366-1" do
      let(:pubid) { "IEC 62366-1" }

      it_behaves_like "converts pubid to pubid"
    end

    context "IEC 60384-23:2023 ED3" do
      let(:pubid) { "IEC 60384-23:2023 ED3" }

      it_behaves_like "converts pubid to pubid"
    end

    context "IEC 61834-1:1998+AMD1:2001 CSV" do
      let(:pubid) { "IEC 61834-1:1998+AMD1:2001 CSV" }

      it_behaves_like "converts pubid to pubid"
    end

    context "DD 240-1:1997" do
      let(:pubid) { "DD 240-1:1997" }

      it_behaves_like "converts pubid to pubid"
    end

    context "BS 4592-0:2006+A1:2012" do
      let(:pubid) { "BS 4592-0:2006+A1:2012" }

      it_behaves_like "converts pubid to pubid"
    end

    context "PD 5500:2021+A2:2022" do
      let(:pubid) { "PD 5500:2021+A2:2022" }

      it_behaves_like "converts pubid to pubid"
    end

    context "PAS 3002:2018+C1:2018" do
      let(:pubid) { "PAS 3002:2018+C1:2018" }

      it_behaves_like "converts pubid to pubid"
    end
  end
end
