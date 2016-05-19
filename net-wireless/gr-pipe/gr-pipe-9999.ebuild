EAPI=5

inherit cmake-utils

DESCRIPTION="Make GNU Radio blocks with standard pipes"
HOMEPAGE="https://github.com/jolivain/gr-pipe"

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/povik/gr-pipe.git"
	EGIT_SOURCEDIR="${WORKDIR}/${PN}"
	KEYWORDS=""
	S="${WORKDIR}/${PN}"
else
	die "This software does not provide source package yet :("
fi

LICENSE="GPL"
SLOT="0"

RDEPEND="
	>=net-wireless/gnuradio-3.7
"

DEPEND="${RDEPEND}"
