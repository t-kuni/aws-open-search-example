FROM golang:1.18.3-stretch as build
WORKDIR /src
COPY . /src
RUN go build -o /build/createIndexDisabledRefresh /src/cmd/createIndexDisabledRefresh.go
RUN go build -o /build/deleteIndex /src/cmd/deleteIndex.go
RUN go build -o /build/disableRefreshIndex /src/cmd/disableRefreshIndex.go
RUN go build -o /build/enableRefreshIndex /src/cmd/enableRefreshIndex.go
RUN go build -o /build/insertDocuments /src/cmd/insertDocuments.go
RUN go build -o /build/search /src/cmd/search.go

FROM golang:1.18.3-stretch as run
COPY --from=build /build/* /app/
RUN chmod +x /app/*
WORKDIR /app
ENV PATH $PATH:/app