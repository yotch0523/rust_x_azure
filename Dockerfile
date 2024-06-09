FROM debian:bullseye-slim
COPY ./target/release/rust_x_azure .
CMD ["./rust_x_azure"]