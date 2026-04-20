FROM node:18 AS builder                                         
RUN npm ci
RUN ./seal fix --mode all        # sealed builder — should NOT count (not final stage)
                                                                                                                                            
FROM node:18-slim
RUN npm ci                                                                                                                                    
# Line continuation split — the case _LINE_CONTINUATION_RE now handles
RUN --mount=type=secret,id=SEAL_TOKEN \                                                                                                       
    export SEAL_TOKEN=$(cat /run/secrets/SEAL_TOKEN) && \                                                                                     
    ./seal fix --mode all --remove-cli   