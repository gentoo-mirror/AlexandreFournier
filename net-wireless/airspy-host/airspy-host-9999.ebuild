# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils udev

DESCRIPTION="Usemode driver and associated tools for airspy"
HOMEPAGE="http://www.airspy.com"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/airspy/host.git"
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI="https://github.com/airspy/host/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/airspyone_host-${PV}"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE="+udev"

DEPEND="virtual/udev"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DINSTALL_UDEV_RULES=$(usex udev)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

    if use udev; then
		udev_newrules "${D}etc/udev/rules.d/52-airspy.rules" 52-airspy.rules
		rm -rf "${D}etc"
	fi
}

pkg_postinst() {
    use udev && udev_reload
}
