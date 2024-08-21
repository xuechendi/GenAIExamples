cd ${WORKDIR}/GenAIComps/
echo $PWD

echo "==============Building dataprep image================="
# cp ingest_data.py ${WORKDIR}/GenAIComps/comps/dataprep/redis/langchain/prepare_doc_redis.py
docker build --no-cache -t opea/dataprep-redis:latest --build-arg https_proxy=$https_proxy --build-arg http_proxy=$http_proxy -f comps/dataprep/redis/langchain/docker/Dockerfile .
echo "==============Successfully built dataprep image================="

echo "==============Building embedding-tei image================="
docker build --no-cache -t opea/embedding-tei:latest --build-arg https_proxy=$https_proxy --build-arg http_proxy=$http_proxy -f comps/embeddings/langchain/docker/Dockerfile .
echo "==============Successfully built embedding-tei image================="

echo "==============Building retriever-redis image================="
docker build --no-cache -t opea/retriever-redis:latest --build-arg https_proxy=$https_proxy --build-arg http_proxy=$http_proxy -f comps/retrievers/langchain/redis/docker/Dockerfile .
echo "==============Successfully built retriever-redis image================="

echo "==============Building reranking-tei image================="
docker build --no-cache -t opea/reranking-tei:latest --build-arg https_proxy=$https_proxy --build-arg http_proxy=$http_proxy -f comps/reranks/tei/docker/Dockerfile .
echo "==============Successfully built reranking-tei image================="

cd $WORKDIR/GenAIExamples/AgentQnA/retrieval_tool/docker/
echo $PWD
echo "==============Building retrieval-tool image================="
docker build --no-cache -t opea/retrievaltool:latest --build-arg https_proxy=$https_proxy --build-arg http_proxy=$http_proxy -f Dockerfile_retrievaltool .
echo "==============Successfully built embedding-tei image================="