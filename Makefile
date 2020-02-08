# choose gpu or cpu version of Chroma to compile
CHROMA=/home/renqiang/Software/CLQCD/chroma_build
#chroma compiled by Ming Gong
#CHROMA=/opt/software/usqcd/compiled/quda.20151122
#CHROMA=/opt/software/usqcd/compiled/mpi.20151212
#CHROMA=/opt/software/usqcd/compiled/working
#chroma compiled with qdp-jit & quda
#CHROMA=/home/sunwei/software/chroma_qdpjit_quda/build

#chroma compiled with qdp-jit only
#CHROMA=/home/sunwei/software/chroma_qdpjit_only/build

#chroma compiled with qdp++ only
#CHROMA=/home/sunwei/software/chroma_qdp++_build

#CHROMA=/home/sunwei/software/chroma_multigpu_cuda9.1/build

CONFIG=$(CHROMA)/bin/chroma-config
CXX=$(shell $(CONFIG) --cxx)
CXXFLAGS=$(shell $(CONFIG) --cxxflags) -I.
LDFLAGS=$(shell $(CONFIG) --ldflags) -L/opt/software/cuda/lib64
#LDFLAGS=-L/home/sunwei/software/usqcd_software_build/lib \
	-fopenmp -L/opt/software/cuda/lib64 -L/home/sunwei/software/quda-0.7.2/lib \
	#-L/opt/software/gcc-4.9.3/lib64
LIBS=$(shell $(CONFIG) --libs) 

HDRS=mom_sh_source_const.h\
     mom_sh_sink_smearing.h\
     mom_gaus_quark_smearing.h
OBJS=chroma.o \
     mom_sh_source_const.o\
     mom_sh_sink_smearing.o\
     mom_gaus_quark_smearing.o
chroma_cpu_mom: $(OBJS)
	$(CXX) -o $@ $(CXXFLAGS) $(OBJS) $(LDFLAGS) $(LIBS)

%.o: %.cc $(HDRS)
	$(CXX) $(CXXFLAGS) -c $< 

clean:
	rm -rf chroma_gpu chroma_cpu_mom $(OBJS) *~
