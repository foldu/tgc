include!("src/opt.rs");

const BIN: &str = "tgc";
const TARGET: &str = "target/completions";

fn main() {
    let mut opt = Opt::clap();

    std::fs::create_dir_all(TARGET).expect("Can't create target dir");

    opt.gen_completions(BIN, structopt::clap::Shell::Zsh, TARGET);
    opt.gen_completions(BIN, structopt::clap::Shell::Bash, TARGET);
    opt.gen_completions(BIN, structopt::clap::Shell::Fish, TARGET);
}
