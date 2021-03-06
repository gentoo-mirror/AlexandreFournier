# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

WANT_AUTOMAKE="1.4"

inherit eutils flag-o-matic autotools

DESCRIPTION="A Steganography detector for JPEG"
HOMEPAGE="http://www.outguess.org/"
SRC_URI="https://codeload.github.com/AlexandreFournier/stegdetect/tar.gz/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="X"
RDEPEND="sys-apps/file
	dev-libs/glib:1
	X? ( x11-libs/gtk+:1 )"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i 's!EXTRA_PROGRAMS = xsteg!EXTRA_PROGRAMS =!' Makefile.am
	sed -i 's! @XSTEG@!!' Makefile.am
}

src_configure() {
	./configure
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	insinto /usr/share/stegbreak/
	doins rules.ini
	dobin stegbreak stegcompare stegdeimage stegdetect
#	use X && dobin xsteg
	doman *.1
}
