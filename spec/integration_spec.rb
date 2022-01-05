require_relative('../lib/app')

RSpec.describe 'how-many' do
  let(:usage) { "Usage:

./how-many <units> in NUMBER <units> [options]
./how-many <units> till <time|date|datetime> [options]

units       is one of the following: seconds, minutes, days, weeks,
            months, or years. The first unit specified is usually the smaller.

in          unit conversion from the first units specified to the second. For
            example, specifying ./howmany seconds in 24 hours will tell you
            how many seconds are in 24 hours.

**Below Options Not Implemented Yet**
till        calculate how many units till time/datetime. For example,
            specifying ./howmany days till 2020/08/10 will tell you how many
            days it is until the 8th of October 2020.

time        is a time specified as hh:mm:ss (am|pm) in 12h or 24h

date        is a date, specified in whatever your local date format is.
            Remember to escape special shell chars (if any) and spaces, or
            just surround your date with quotes.

datetime    is a datetime, with date formatted as described as above,
            and time formatted as described above also.

Options:
    -t, --type=TYPE                  output type, f for float (default), i for integer

Metadata Options:
    -h, --help                       show this message
    -V, --version                    show program version
" }

  describe 'displays usage text' do
    it 'when no args specified' do
      expect{ system('./how-many') }.to output(usage).to_stdout_from_any_process
    end

    it 'when --help is specified' do
      expect{ system('./how-many --help') }.to output(usage).to_stdout_from_any_process
    end

    it 'when --h is specified' do
      expect{ system('./how-many -h') }.to output(usage).to_stdout_from_any_process
    end
  end

  describe 'correctly performs calculations' do
    it 'when correct args passed' do
      expect{ system('./how-many seconds in 1 hour') }.to output("3600.0\n").to_stdout_from_any_process
    end
  end
end
