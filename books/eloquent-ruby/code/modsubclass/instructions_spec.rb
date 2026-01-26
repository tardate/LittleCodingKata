#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "ins_basic"
require_relative "ins_eval"
require_relative "ins_def_meth"

shared_examples "instructions" do |ins_class|
  let(:omelette) do
    ins = ins_class.new(title: "Make an Omelette", author: "Russ")
    ins.introduction("Omelettes are good.")
    ins.step("First break some eggs.")
    ins.warning("Careful, the shells are sharp.")
    ins
  end

  it "generates the correct content" do
    expect(omelette.content).to match(/Omelettes are.*First.*Careful/m)
  end

  it "has the proper paragraph defs" do
    para = omelette.paragraphs
    expect(para.map &:font).to eq(%i[arial arial mono])
    expect(para.map &:font_size).to eq([12, 10, 14])
  end

  it "has the methods we expect " do
    expect(ins_class.instance_methods).to include(:introduction)
    expect(ins_class.instance_methods).to include(:step)
    expect(ins_class.instance_methods).to include(:warning)
  end

  it "has the correct header info" do
    expect(omelette.title).to match(/Make an/)
    expect(omelette.author).to eq("Russ")
  end
end

describe Basic::Instructions do
    include_examples "instructions", Basic::Instructions
end

describe WithClassEval::Instructions do
    include_examples "instructions", WithClassEval::Instructions
end

describe WithDefineMethod::Instructions do
    include_examples "instructions", WithDefineMethod::Instructions
end


