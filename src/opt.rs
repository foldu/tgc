use std::path::PathBuf;
use structopt::StructOpt;

#[derive(StructOpt)]
pub struct Opt {
    #[structopt(short, long)]
    pub json: bool,

    #[structopt(subcommand)]
    pub cmd: Subcmd,
}

#[derive(StructOpt)]
pub enum Subcmd {
    AddFileTags { file: PathBuf, tags: Vec<String> },
    GetFileTags { file: PathBuf },
    GetFilesTags { files: Vec<String> },
    CopyTags { src: PathBuf, dest: PathBuf },
}

