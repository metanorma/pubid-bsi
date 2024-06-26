module Pubid::Bsi
  RSpec.describe Identifier do
    describe "creating new identifier" do
      subject { described_class.create(**{ number: number }.merge(params)) }
      let(:number) { 123 }
      let(:params) { {} }

      it "renders default publisher" do
        expect(subject.to_s).to eq("BS #{number}")
      end

      context "with part and year" do
        let(:params) { { part: 1, year: 1999 } }

        it "renders identifier with part and year" do
          expect(subject.to_s).to eq("BS #{number}-1:1999")
        end
      end

      context "when have month and edition" do
        let(:params) { { year: 1999, month: 1, edition: 1 } }

        it "renders identifier with part and year" do
          expect(subject.to_s).to eq("BS #{number}:1999")
        end

        context "when Flex type" do
          let(:params) { { type: :flex, year: 1999, month: 1, edition: 1 } }

          it "renders identifier with part and year" do
            expect(subject.to_s).to eq("BSI Flex #{number} v1:1999-1")
          end
        end
      end

      context "PAS type" do
        let(:params) { { type: :pas } }

        it "renders PAS identifier" do
          expect(subject.to_s).to eq("PAS #{number}")
        end
      end

      context "PD type" do
        let(:params) { { type: :pd } }

        it "renders PD identifier" do
          expect(subject.to_s).to eq("PD #{number}")
        end
      end

      context "Flex type" do
        let(:params) { { type: :flex, edition: "3.0" } }

        it "renders Flex identifier" do
          expect(subject.to_s).to eq("BSI Flex #{number} v3.0")
        end
      end

      context "supplements" do
        let(:params) { { supplement: Identifier.create(type: type, number: 1, year: 1999) } }

        context "amendment" do
          let(:type) { :amd }

          it "renders amendment" do
            expect(subject.to_s).to eq("BS #{number}+A1:1999")
          end
        end

        context "corrigendum" do
          let(:type) { :cor }

          it "renders amendment" do
            expect(subject.to_s).to eq("BS #{number}+C1:1999")
          end
        end
      end

      context "adoptions" do
        let(:adopted) { Pubid::Iso::Identifier.create(number: 1) }
        let(:params) { { adopted: adopted } }

        it "renders adopted identifier" do
          expect(subject.to_s).to eq("BS ISO 1")
        end

        context "with type" do
          let(:params) { { adopted: adopted, type: :dd } }

          it "renders adopted identifier" do
            expect(subject.to_s).to eq("DD ISO 1")
          end
        end

        context "adopted with year" do
          let(:adopted) { Pubid::Iso::Identifier.create(number: 1, year: 2012) }

          it "renders adopted identifier with year" do
            expect(subject.to_s).to eq("BS ISO 1:2012")
          end

          context "base document has year" do
            let(:params) { { adopted: adopted, year: 2013 } }

            it "renders adopted identifier with base document's year" do
              expect(subject.to_s).to eq("BS ISO 1:2013")
            end

            context "adopted document have another adopted document" do
              let(:adopted) { Pubid::Cen::Identifier.parse("EN ISO 639:2012") }

              it "renders adopted identifier with base document's year" do
                expect(subject.to_s).to eq("BS EN ISO 639:2013")
              end
            end
          end
        end

        context "base document has year" do
          let(:params) { { adopted: adopted, year: 2013 } }

          it "renders adopted identifier with base document's year" do
            expect(subject.to_s).to eq("BS ISO 1:2013")
          end
        end
      end

      context "expert commentary" do
        let(:params) { { type: :ec, base: described_class.create(number: number) } }

        it "renders expert commentary identifier" do
          expect(subject.to_s).to eq("BS #{number} ExComm")
        end
      end

      context "tracked changes" do
        let(:params) { { tracked_changes: true } }

        it "renders tracked changes identifier" do
          expect(subject.to_s).to eq("BS #{number} - TC")
        end
      end

      context "national annex" do
        let(:base) { described_class.create(number: number) }
        let(:params) { { type: :na, base: base } }

        it "renders national annex" do
          expect(subject.to_s).to eq("NA to BS #{number}")
        end

        context "with ammendment" do
          let(:params) { { type: :na, supplement: described_class.create(type: :amd, number: 1, year: 1999), base: base } }

          it "renders national annex" do
            expect(subject.to_s).to eq("NA+A1:1999 to BS #{number}")
          end
        end
      end

      context "pdf" do
        let(:params) { { pdf: true } }

        it "renders pdf identifier" do
          expect(subject.to_s).to eq("BS #{number} PDF")
        end
      end

      context "collection" do
        let(:params) do
          { type: :collection,
            identifiers: [Identifier.create(number: 1), Identifier.create(number: 2)],
            year: 1999,
            supplement: described_class.create(type: :amd, number: 1, year: 2000) }
        end

        it "renders collection with supplement and year" do
          expect(subject.to_s).to eq("BS 1/2:1999+A1:2000")
        end
      end
    end
  end
end
