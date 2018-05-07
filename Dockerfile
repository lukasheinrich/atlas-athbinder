FROM atlas/athanalysis:21.2.26
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/lcg/zeromq/4.1.6-b4186/x86_64-slc6-gcc62-opt/lib' >> /home/atlas/setup.sh 

USER root
ADD entrypoint.sh /entrypoint.sh
RUN chown atlas /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN usermod -u 1000 atlas
RUN find /home -user 500 -type f -exec chown -h atlas '{}' \;

USER atlas
#RUN source ~/release_setup.sh && pip install -U jupyter --user
RUN echo 'export PATH=$PATH:$HOME/.local/bin' >> /home/atlas/setup.sh
RUN source /home/atlas/release_setup.sh && cp -r $ROOTSYS/etc/notebook/kernels/root ~/.local/share/jupyter/kernels

ENTRYPOINT ["/entrypoint.sh"]
