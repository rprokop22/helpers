import polars as pl


def load_dataframe(path1, path2):
    df1 = pl.read_parquet(path1)
    df2 = pl.read_parquet(path1)

    # for line in df1["dateofbirth"]:
    #     print(line)

    min_date_1 = df1["dateofbirth"].min()
    max_date_1 = df1["dateofbirth"].max()
    print("min_date_1: ", min_date_1)
    print("max_date_1: ", max_date_1)
    print("---------------------------------------------------------------------")

    min_date_2 = df2["dateofbirth"].min()
    max_date_2 = df2["dateofbirth"].max()
    print("min_date_2: ", min_date_2)
    print("max_date_2: ", max_date_2)

    df1 = df1.with_columns(
        df1["dateofbirth"].apply(
            lambda x: pl.when(x < pl.lit("1900-01-01"))
            .then(pl.lit("1900-01-01"))
            .when(x > pl.lit("2100-12-31"))
            .then(pl.lit("2100-12-31"))
            .otherwise(x)
        )
    )
    df2 = df2.with_columns(
        df2["dateofbirth"].apply(
            lambda x: pl.when(x < pl.lit("1900-01-01"))
            .then(pl.lit("1900-01-01"))
            .when(x > pl.lit("2100-12-31"))
            .then(pl.lit("2100-12-31"))
            .otherwise(x)
        )
    )

    print("----------------------------------------------------------------")

    print("min_date_1: ", min_date_1)
    print("max_date_1: ", max_date_1)
    print("---------------------------------------------------------------------")

    min_date_2 = df2["dateofbirth"].min()
    max_date_2 = df2["dateofbirth"].max()
    # for line in df2["dateofbirth"]:
    #     if line is not None:
    #         print(line)

    breakpoint()
    return df1


if __name__ == "__main__":
    path1 = (
        "/Users/robbie/Documents/esp_customers_lynx_20241211_1201570000_part_00.parquet"
    )
    path2 = (
        "/Users/robbie/Documents/esp_customers_lynx_20241212_0000390001_part_00.parquet"
    )
    load_dataframe(path1, path2)
