#
# Copyright (C) 2016 CompuLab ltd.
# Author: Andrey Gelman <andrey.gelman@compulab.co.il>
# License: GPL-2
#

DAEMONDIR = ../fpsvc
DAEMONBIN = $(DAEMONDIR)/bin/airtop-fpsvc

OBJDIR  = obj
BINDIR  = bin
OUTFILE = $(BINDIR)/airtop-fpsvc

MKDIR_CMD   = mkdir -p
CP_CMD      = sudo cp
RM_CMD      = sudo rm -rf

all: daemon overlay $(BINDIR)
	dpkg-deb --build $(OBJDIR)/deb-upstart $(OUTFILE)_upstart.deb

check: all
	lintian $(OUTFILE)_upstart.deb

.PHONY: daemon
daemon:
	make -C $(DAEMONDIR)

.PHONY: overlay
overlay: $(OBJDIR)
	$(CP_CMD) -a deb-upstart $(OBJDIR)
	$(CP_CMD) $(DAEMONBIN) $(OBJDIR)/deb-upstart/usr/sbin

$(OBJDIR):
	$(MKDIR_CMD) $(OBJDIR)

$(BINDIR):
	$(MKDIR_CMD) $(BINDIR)

.PHONY: clean
clean:
	$(RM_CMD) $(OBJDIR)/*
	$(RM_CMD) $(BINDIR)/*

